Feature: wordpress-password-checker

  As a wordpress password checer,
  I would like to check password with encypted password stored in database.
  
  Scenario: right password	
    Given I start password checker
    When I input plain password "pass1234"
    And encrypted password is "$P$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/"
    Then I should see "true"

  Scenario: wrong password	
    Given I start password checker
    When I input plain password "1234pass"
    And encrypted password is "$P$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/"
    Then I should see "false"
