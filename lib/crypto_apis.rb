class CryptoApis

  def initialize()
    @ticker = ''
    @ticker_symbol = ''
    @ticker_name = ''
    @ticker_price = ''
    @market_cap = 0.0
    @currency = 'USD'
    @time = DateTime.now.to_i
    @total_market_cap = Coinmarketcap.global['total_market_cap_usd'].to_f
  end

  def set_ticker(id)
    begin
      @ticker = Coinmarketcap.coin(id)[0]
      @ticker_symbol = @ticker['symbol']
      @ticker_name = @ticker['name']
      @ticker_price = @ticker['price_usd'].to_f
    rescue => e
      return false
    end
  end

  def top_fifty?
    @ticker['rank'].to_i < 50 ? true : false
  end

  def coin_market_cap
    @ticker.present? ? @ticker['market_cap_usd'].to_f : 0.0
  end

  def percent_marketcap
    percent = ( coin_market_cap / @total_market_cap ) * 100
    percent == 0.0 ? 'No data available' : "#{percent.round(2)} %"
  end

  def alltime_high
    # time format to be to_i format of a date time
    y = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{@ticker_symbol}&tsym=#{@currency}&limit=90&aggregate=1&toTs=#{@time}")
    a = y["Data"][0..90].map{ |x| x["high"] }
    alltimehigh = a.max
    percent = (a.max/ @ticker_price)*100
    percent < 250 ?  "within 250% range from 90 day high price. price today is #{@ticker_price}, 90 day high is #{alltimehigh}" :  "not within 250% range of 90 day high price, price today is #{@ticker_price}, 90 day high is #{alltimehigh}"
  end



end