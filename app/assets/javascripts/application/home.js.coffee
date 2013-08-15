$ ->
  championshipFilter = new ChampionshipFilter($("#championship"))
  setTimeout("location.reload(true);", 60000);

  $('#gallery').galleryView({
    panel_width: 990,
    panel_scale: 'fit',
    enable_overlays: true,
    overlay_position: 'bottom'
  })
