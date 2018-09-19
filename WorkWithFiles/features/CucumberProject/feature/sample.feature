Feature: files

  Scenario: Rename a file
    Given I have a file
    When I rename a file
    Then file was renamed

  Scenario: Rename a file
    Given I have not a file
    When I rename a file
    Then file was not renamed

  Scenario: Delete a file
    Given I have a file
    When I delete a file
    Then file was deleted

  Scenario: Rename a file
    Given I have not a file
    When I delete a file
    Then file was not deleted

  Scenario Outline: Create a file
    When I create file with <Access> right access
    Then file with right was created
    Examples:
      |Access   |
      |w        |
      |w+       |
      |a        |
      |a+       |
      |default  |

  Scenario Outline: Create a file
    When I create file with <Access> right access
    Then file with right was not created
    Examples:
      |Access   |
      |r        |
      |e        |

  Scenario Outline: Create a file existing
    Given I have a file
    When I create file with <Access> right access
    Then existing file with right was not created
    Examples:
      | Access   |
      | default  |

  Scenario: Read a file
    Given I have a file
    And with default text
    When I read a file
    Then I see the text from file

  Scenario Outline: Write in to file
    Given I have a file
    And with default text
    When I write text in to file with <Access> right access
    Then I see the text with <Access> right access
    Examples:
      |Access   |
      |w        |
      |w+       |
      |a        |
      |a+       |
      |e        |
      |default  |

  Scenario Outline: Write in to file
    Given I have a file
    And with default text
    When I write default text in to file with <Access> right access
    Then I see the default text with <Access> right access
    Examples:
      |Access   |
      |w        |
      |w+       |
      |a        |
      |a+       |
      |e        |
      |default  |

  Scenario: Read a file
    Given I have not a file
    When I read a file
    Then I see error message

  Scenario: Output information about created files
    Given I have not a file
    When output information about created files
    Then I do not see information about files

  Scenario: Output information about created files
    Given I have a file
    When output information about created files
    Then I see information about file

  Scenario: Output information about created files
    Given I have 2 files
    When output information about created files
    Then I see information about files
