puts "Scraper de Hoteles: Booking"

require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv


link_esmeraldas = 'https://www.booking.com/region/ec/esmeraldas.en-gb.html?aid=390156&label=duc511jc-1BCAIoQUICZWNIM1gDaEGIAQGYAQm4AQfIAQzYAQHoAQGIAgGoAgO4AqWU7Z0GwAIB0gIkOTNkY2I5NmYtMjRkZS00OGIzLWJkMDYtN2FjMzBhNGE1NDVh2AIF4AIB&sid=d937cab748728b6d0dd262df88420fff'
i = 0
hotelesHTML = URI.open(link_esmeraldas)
datos = hotelesHTML.read
parsed_content = Nokogiri::HTML(datos) # si pasa es porque la pagina si sigue estandares

hoteles_container = parsed_content.css('.content__col')
puts("hotel_name, start, link_hotel, precio\n")

hoteles_container.css('.sr__card_content').each do |hotel_post|
  title = hotel_post.css('.sr__card_main').css('.bui-card__title').inner_text.strip
  title = title.sub("



                  ", ';')
  title_a = title.split(';', 2)
  nombre = title_a.first.strip
  start = title_a.last.strip
  
  href_hotel = hotel_post.css('.sr__card_main').css('.bui-spacer--medium').at_css('a')
  href_hotel = href_hotel['href']

  # puntaje_review
  precio = hotel_post.css('.sr__card_price').inner_text.strip.split(" ",3)[2].sub("per night","")

  puts("#{nombre}, #{start}, #{href_hotel}, #{precio}")
end
