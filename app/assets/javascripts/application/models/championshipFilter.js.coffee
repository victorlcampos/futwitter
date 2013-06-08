window.ChampionshipFilter = class ChampionshipFilter
  constructor: (@selected_championship) ->
    this.filter_championships()
    @selected_championship.on('change', { filter: this} , (event) ->
      event.data.filter.filter_championships()
    )

  get_selected_championship: ->
    @selected_championship.val()

  filter_championships: ->
    championship_id = this.get_selected_championship()
    $('.filter').not('.championship_'+championship_id ).hide();
    $('.filter').filter('.championship_'+championship_id ).show();