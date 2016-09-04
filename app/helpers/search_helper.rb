module SearchHelper
  def generate_highlight_group(text)
    result, flag = [], false
    text.split(/<\/?em>/).each do |word|
      result << [word, flag]
      flag = !flag
    end
    result
  end
end
