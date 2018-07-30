class CryptoApis

  def initialize()
    @ticker = ''
    @ticker_symbol = ''
    @ticker_name = ''
    @ticker_price = ''
    @market_cap = 0.0
    @currency = 'USD'
    @current_time = DateTime.now.to_i
    @time = DateTime.now.to_i
    @total_market_cap = Coinmarketcap.global['total_market_cap_usd'].to_f
    @top_exchanges = ["CoinBene", "Binance", "OKEX", "BigONE", "CoinEx"]
  end

  def set_all(id, time )
    set_ticker(id)
    set_time(time)
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

  def set_time(time)
    @time = time
  end

  def top_fifty?
    @ticker['rank'].to_i < 50 ? true : false
  end

  def event_action
    x =  (@time + 3.days).to_i
    y = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{@ticker_symbol}&tsym=#{@currency}&limit=6&aggregate=1&toTs=#{x}")
    low = y["Data"].map{ |x| x["low"] }
    high = y["Data"].map{ |x| x["high"] }
    pre_event_prices = format_event_prices(high[0..2], low[0..2])
    price_event_day = format_event_prices(high[3], low[3])
    post_event_prices = format_event_prices(high[4..6], low[4..6])
    [pre_event_prices, price_event_day, post_event_prices]
  end

  def format_event_prices(highs,lows)
    pairs = []
    pairs = " high:#{highs}, low:#{lows} " unless highs.kind_of?(Array)
    if highs.kind_of?(Array)
      c = 0
      highs.each do |v|
        pairs << " high: #{v}, low:#{lows[c]}  "
        c+= 1
      end
      pairs.join(' || ')
    end
    pairs
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
    y = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{@ticker_symbol}&tsym=#{@currency}&limit=90&aggregate=1&toTs=#{@current_time}")
    a = y["Data"][0..90].map{ |x| x["high"] }
    alltimehigh = a.max
    percent = (a.max/ @ticker_price)*100
    percent < 250 ?  "within 250% range from 90 day high price. price today is #{@ticker_price}, 90 day high is #{alltimehigh}" :  "not within 250% range of 90 day high price, price today is #{@ticker_price}, 90 day high is #{alltimehigh}"
  end

  def last_seven
    price_7_days = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{@ticker_symbol}&tsym=#{@currency}&limit=7&aggregate=1&toTs=#{@current_time}")
    high = price_7_days["Data"][0..7].map{ |x| x["high"] }.max
    listing_open = price_7_days["Data"].first["open"]
    percent = (high/listing_open)*100.0
    percent > 200.00 ? "coin has seen #{percent} increase in price since listing already" : "coin has not reached over 200% diff in price"
  end

  def top_exchanges
    return "can't check btc against itself" if @ticker_symbol.downcase == 'btc'
    exchanges = HTTParty.get("https://min-api.cryptocompare.com/data/top/exchanges/full?fsym=#{@ticker_symbol}&tsym=BTC&limit=5")["Data"]["Exchanges"].map{ |x| x["MARKET"] }
    matching = exchanges & @top_exchanges
    !matching.empty?
  end

end