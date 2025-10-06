"""
BBVA Custom Library for Robot Framework
Librería personalizada para testing BBVA con integración QMetry y JIRA
"""

import json
import os
import requests
import time
from datetime import datetime
from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class BBVALibrary:
    """Custom library for BBVA testing automation with QMetry and JIRA integration."""
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LIBRARY_VERSION = '1.0'
    
    def __init__(self):
        self.builtin = BuiltIn()
        self.test_results = []
        self.session_data = {}
        self.qmetry_config = self._load_qmetry_config()
        self.jira_config = self._load_jira_config()
        
    def _load_qmetry_config(self):
        """Load QMetry configuration from environment or config file."""
        try:
            config_path = os.path.join(os.getcwd(), 'qmetry-mcp', 'mcp-config-example.json')
            if os.path.exists(config_path):
                with open(config_path, 'r') as f:
                    config = json.load(f)
                return config.get('qmetry', {})
        except Exception as e:
            self.builtin.log(f"Warning: Could not load QMetry config: {e}")
        return {}
    
    def _load_jira_config(self):
        """Load JIRA configuration from environment variables."""
        return {
            'base_url': os.getenv('JIRA_BASE_URL', 'https://neo-qa.atlassian.net'),
            'email': os.getenv('JIRA_EMAIL'),
            'token': os.getenv('JIRA_TOKEN')
        }
    
    @keyword
    def initialize_test_session(self, test_suite_name, browser='chrome'):
        """Initialize a new test session with tracking."""
        session_id = f"BBVA-{datetime.now().strftime('%Y%m%d-%H%M%S')}"
        
        self.session_data = {
            'session_id': session_id,
            'test_suite': test_suite_name,
            'browser': browser,
            'start_time': datetime.now().isoformat(),
            'test_count': 0,
            'passed_count': 0,
            'failed_count': 0,
            'tests': []
        }
        
        self.builtin.log(f"Test session initialized: {session_id}")
        return session_id
    
    @keyword
    def record_test_start(self, test_name, qmetry_test_id=None, figma_node_id=None):
        """Record the start of a test case."""
        test_data = {
            'name': test_name,
            'qmetry_id': qmetry_test_id,
            'figma_node': figma_node_id,
            'start_time': datetime.now().isoformat(),
            'status': 'RUNNING',
            'screenshots': [],
            'errors': []
        }
        
        self.session_data['tests'].append(test_data)
        self.session_data['test_count'] += 1
        
        self.builtin.log(f"Test started: {test_name} (QMetry: {qmetry_test_id})")
    
    @keyword
    def record_test_result(self, test_name, status, error_message=None):
        """Record the result of a test case."""
        for test in self.session_data['tests']:
            if test['name'] == test_name:
                test['status'] = status
                test['end_time'] = datetime.now().isoformat()
                
                if error_message:
                    test['errors'].append(error_message)
                
                if status == 'PASS':
                    self.session_data['passed_count'] += 1
                else:
                    self.session_data['failed_count'] += 1
                
                break
        
        self.builtin.log(f"Test result recorded: {test_name} - {status}")
    
    @keyword
    def add_test_screenshot(self, test_name, screenshot_path, description=None):
        """Add screenshot evidence to test case."""
        for test in self.session_data['tests']:
            if test['name'] == test_name:
                screenshot_data = {
                    'path': screenshot_path,
                    'timestamp': datetime.now().isoformat(),
                    'description': description or 'Test evidence screenshot'
                }
                test['screenshots'].append(screenshot_data)
                break
        
        self.builtin.log(f"Screenshot added to {test_name}: {screenshot_path}")
    
    @keyword
    def update_qmetry_test_result(self, qmetry_test_id, execution_status, comment=None):
        """Update test execution result in QMetry."""
        if not self.qmetry_config:
            self.builtin.log("Warning: QMetry config not available, skipping update")
            return False
        
        try:
            # QMetry API call would go here
            # This is a placeholder for the actual API integration
            self.builtin.log(f"QMetry test {qmetry_test_id} updated to {execution_status}")
            return True
        except Exception as e:
            self.builtin.log(f"Error updating QMetry: {e}")
            return False
    
    @keyword
    def validate_figma_component_mapping(self, figma_node_id, component_type):
        """Validate that Figma component matches expected type."""
        figma_mappings = {
            '425:6520': 'Dashboard',
            '378:10502': 'Product Detail',
            '287:1292': 'Information Detail'
        }
        
        expected_component = figma_mappings.get(figma_node_id)
        if expected_component == component_type:
            self.builtin.log(f"Figma component mapping valid: {figma_node_id} -> {component_type}")
            return True
        else:
            error_msg = f"Figma mapping mismatch: {figma_node_id} expected {expected_component}, got {component_type}"
            self.builtin.log(error_msg)
            return False
    
    @keyword
    def get_bbva_environment_config(self, environment='qa'):
        """Get BBVA environment configuration."""
        environments = {
            'qa': {
                'desa1_qa': {
                    'login_url': 'https://desa1-qa.bbva.com.ar/fnetcore/login/index.html',
                    'name': 'QA Environment 1'
                },
                'desa16_qa': {
                    'login_url': 'https://desa16-qa.bbva.com.ar/fnetcore/login/index.html',
                    'name': 'QA Environment 16 (Fallback)'
                }
            }
        }
        
        return environments.get(environment, environments['qa'])
    
    @keyword
    def validate_responsive_viewport(self, width, height, expected_layout='desktop'):
        """Validate that viewport matches expected responsive layout."""
        viewport_categories = {
            'mobile': {'max_width': 768},
            'tablet': {'min_width': 769, 'max_width': 1024},
            'desktop': {'min_width': 1025}
        }
        
        category = None
        for cat, bounds in viewport_categories.items():
            if 'min_width' in bounds and 'max_width' in bounds:
                if bounds['min_width'] <= width <= bounds['max_width']:
                    category = cat
                    break
            elif 'max_width' in bounds and width <= bounds['max_width']:
                category = cat
                break
            elif 'min_width' in bounds and width >= bounds['min_width']:
                category = cat
                break
        
        if category == expected_layout:
            self.builtin.log(f"Viewport validation passed: {width}x{height} is {category}")
            return True
        else:
            self.builtin.log(f"Viewport validation failed: {width}x{height} is {category}, expected {expected_layout}")
            return False
    
    @keyword
    def generate_test_report(self, output_path=None):
        """Generate comprehensive test execution report."""
        if not output_path:
            timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
            output_path = f"bbva_test_report_{timestamp}.json"
        
        # Add session summary
        self.session_data['end_time'] = datetime.now().isoformat()
        self.session_data['duration'] = self._calculate_session_duration()
        self.session_data['success_rate'] = self._calculate_success_rate()
        
        # Write report
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(self.session_data, f, indent=2, ensure_ascii=False)
        
        self.builtin.log(f"Test report generated: {output_path}")
        return output_path
    
    @keyword
    def wait_for_bbva_page_load(self, timeout=30):
        """Wait for BBVA page to load completely."""
        selenium = self.builtin.get_library_instance('SeleniumLibrary')
        
        # Wait for common BBVA loading indicators to disappear
        try:
            # Check for loading spinner
            selenium.wait_until_element_is_not_visible(
                'xpath://div[contains(@class, "loading") or contains(@class, "spinner")]', 
                timeout=timeout
            )
        except:
            pass  # No loading indicator found
        
        # Additional wait for JavaScript to settle
        time.sleep(2)
        
        self.builtin.log("BBVA page load completed")
    
    @keyword
    def handle_bbva_popup_notifications(self):
        """Handle common BBVA popup notifications."""
        selenium = self.builtin.get_library_instance('SeleniumLibrary')
        
        popup_selectors = [
            'xpath://button[contains(text(), "No me interesa")]',
            'xpath://button[contains(text(), "Cerrar")]',
            'xpath://button[contains(text(), "Continuar")]',
            'xpath://*[@aria-label="Close" or @aria-label="Cerrar"]'
        ]
        
        for selector in popup_selectors:
            try:
                element_present = selenium.get_element_count(selector) > 0
                if element_present:
                    selenium.click_element(selector)
                    self.builtin.log(f"Handled popup with selector: {selector}")
                    time.sleep(1)
            except:
                continue  # Popup not present or already handled
    
    def _calculate_session_duration(self):
        """Calculate session duration in seconds."""
        if 'start_time' in self.session_data:
            start = datetime.fromisoformat(self.session_data['start_time'])
            end = datetime.now()
            return int((end - start).total_seconds())
        return 0
    
    def _calculate_success_rate(self):
        """Calculate test success rate percentage."""
        total = self.session_data['test_count']
        passed = self.session_data['passed_count']
        
        if total == 0:
            return 0
        
        return round((passed / total) * 100, 2)