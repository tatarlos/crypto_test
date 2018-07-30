# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  $input = $('.new_crpyto_info')
  $submitBtn = $('.confirm-btn')

  $ticker = $('.name')
  $marketCap = $('.market-cap')
  $top50 = $('.market-rank')
  $alltimeHigh = $('.all-time-high')
  $lastSeven = $('.last-seven')
  $error = $('.errors')
  $eventAfter = $('.event-after')
  $eventBefore = $('.event-before')
  $eventDate = $('.event-date')

  $topFive = $('.top-5-exchange')

  if $input.length > 0
    console.log('found input')

    submit_data = (data) ->
      $error.hide()
      $.ajax({
        type: "POST",
        url: '/ticker-info',
        dataType: 'json'
        data: data,
        success: (data) ->
          console.log(data)
          $ticker.text(data['coin'])
          $marketCap.text(data['market_cap'])
          $top50.text(data['market_rank'])
          $alltimeHigh.text(data['alltime_high'])
          $lastSeven.text(data['last_seven'])

          $eventBefore.text(data['event_before'])
          $eventDate.text(data['event_date'])
          $eventAfter.text(data['event_after'])

          $topFive.text(data['top_exchange'])

          $submitBtn.removeAttr('disabled')
        error: (data) ->
          $error.show()
          $submitBtn.removeAttr('disabled')
      })

    $input.submit (e)->
      e.preventDefault()
      submit_data($input.serialize())

