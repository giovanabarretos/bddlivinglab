#encoding: utf-8

Dado("que eu acesse o site de eventos do living lab") do
    visit "https://www.sympla.com.br/LivingLabMS" #Visitar um URL

end

Quando("existirem eventos próximos") do

    #page.find('span', text: 'Eventos passados').click #descomentar essa linha caso queira ver eventos passados
  
	sleep(3)
	@items = page.find_all(:xpath, ("//div[@class='col-centered event-box-container-3col margin-bottom-40-lg']/div"))
	@string1 = Array.new()
	@items.each do |item |
		if (item.text!= nil)
			puts item.text
			@string1.push(item.text)
		end
	end
end

Entao("eu devo salvar as informações do evento no dontpad") do
    visit "http://www.dontpad.com/bddnolivinglab"
	sleep(3)
	puts @items.size
	puts @string1.size
	element = find(:id, 'text')
	if (@items.size == 0)
		element.send_keys [:control, 'a']
		element.send_keys ['']
  		element.send_keys("Não existem eventos próximos :(")
	else
		element.send_keys [:control, 'a']
		element.send_keys ['']
    	@string1.each do |str|
    		element.send_keys(str)
    		element.send_keys [:return]
	    end		
		
	end
	sleep(3)
end