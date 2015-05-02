ActiveAdmin.register_page "Scheduling" do
  content do
    render partial: 'form'
  end

  controller do
  	def index
  		@hours = (1..12).to_a
  		@hours.map!{|x| format('%02d', x)}
  		@minutes = (0..59).step(5).to_a
  		@minutes.map!{|x| format('%02d', x)}
  		@ampm = ["am", "pm"]
  	end
  end
end