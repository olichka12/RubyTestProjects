class SearchFirmPage < HeadComponentPage

  CONTAINER_RESULT = {class: 'm_bottom_30 m_xs_bottom_10 m_top_20'}
  FOUNDED_ELEMENT = {class: 'm_bottom_5'}
  #ELEMENT = {xpath: "//div[@class='m_bottom_30 m_xs_bottom_10 m_top_20']/div[#{@element_number}]//a[@class='v_align_base font5 color_main']"}

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def is_container_result
    @driver.find_element(CONTAINER_RESULT).enabled?
  end

  def get_count_founded_element
    @driver.find_elements(FOUNDED_ELEMENT).count
  end

  def get_text_element(element_number)
    #@element_number = element_number
    #@driver.find_element(ELEMENT).text
    @driver.find_element(:xpath, "//div[@class='m_bottom_30 m_xs_bottom_10 m_top_20']/div[#{element_number}]//a[@class='v_align_base font5 color_main']").text
  end

  def check_contains_firm?(firm)
    @check = true
    if is_container_result
      (1..get_count_founded_element).each do |i|
        @check = false unless get_text_element(i).include?(firm)
      end
    end
    @check
  end
end
