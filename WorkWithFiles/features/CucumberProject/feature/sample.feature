Feature: files

  Scenario Outline: Rename and delete a file
    Given I have <file>
    When I  <action> a file
    Then I display the result of <action>
    Examples:
      |file         | action   |
      | a file      | renaming |
      | not a file  | renaming |
      | a file      | deleting |
      | not a file  | deleting |

  Scenario Outline: Create a file
    When I creates file with <access> right access
    Then I display the result of creating
    Examples:
      |access   |
      |w        |
      |w+       |
      |a        |
      |a+       |
      |r        |
      |e        |
      |default  |

  Scenario Outline: Create a file existing
    Given I have <file>
    When I creates file with <access> right access
    Then I display the result of creating
    Examples:
      |file         | access   |
      | a file      | default  |
