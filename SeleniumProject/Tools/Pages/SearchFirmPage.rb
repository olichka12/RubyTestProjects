class SearchFirmPage < HeadComponentPage

  CONTAINER_RESULT = {css: '.m_bottom_30.m_xs_bottom_10.m_top_20'}
  FOUNDED_ELEMENT = {css: '.m_bottom_5'}
  ELEMENT = {css: '.v_align_base.font5.color_main'}

  attr_reader :driver

  def initialize
    @driver = Application.driver
  end

  def is_container_result
    @driver.find_element(CONTAINER_RESULT).enabled?
  end

  def count_founded_element
    @driver.find_elements(FOUNDED_ELEMENT).count
  end

  def text_element(element_number)
    @driver.find_elements(ELEMENT)[element_number - 1].text
  end

  def check_contains_firm?(firm)
    if is_container_result
      (1..count_founded_element).each do |i|
        return false unless text_element(i).include?(firm)
      end
    end
    true
  end
end
