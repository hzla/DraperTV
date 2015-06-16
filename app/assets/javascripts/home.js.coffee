Home =
	init: ->
		$('body').on 'click', '.content-expand-header', @expandContent
		$('body').on 'click', '.featured-tabs button', @showTab
		@mobile = $(window).width() < 1024
		@initCarousel() if @mobile
		@initSlideShow() if !@mobile
		@translated = 0


	showTab: ->
		$('.featured-tabs > button').removeClass('tabs-selected')
		$(@).addClass('tabs-selected')
		$('.content-list').addClass('hide-section')
		$(".#{$(@).attr('data-show')}").toggleClass('hide-section')

	expandContent: ->
		$(@).next().toggle()
		$(@).children('.arrow').toggleClass('rotate180')

	initCarousel: ->
		$('.featured-carousel').slick
			arrow: false
			autoplay: true
			autoplaySpeed: 3000
			speed: 1000
			pauseOnHover: false


	initSlideShow: ->
		$($('.featured-carousel-main .featured-item')[2]).show()

		setInterval ->
			toFadeOut = $('.featured-carousel-main .featured-item:visible').first()
			toFadeOut.fadeOut(1000)

			toFadeIn = toFadeOut.parent().next().find('.featured-item')
			if toFadeIn.length == 0
				toFadeIn = $('.featured-carousel-main .featured-item').first()
			toFadeIn.fadeIn(1000)
		, 5000

		$('.featured-carousel-side .featured-item:lt(2)').show()
		setInterval ->
			toSlideDown = $('.featured-carousel-side .featured-item:lt(2)')
			toHide = toSlideDown.last()
			toShow = $('.featured-carousel-side .featured-item').last()

			toSlideDown.animate
				transform: "translateY(180px)"
			, 1000, ->
				$(@).css('transform' , '')
				toHide.hide()


			toShow.show().css('position', 'absolute').css('top', '-180px')

			toShow.parent().prependTo('.featured-carousel-side').children()
			toShow.animate
				top: "0px"
			, 1000, ->
				$(@).css('position', 'relative')

		, 5000
	

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready

