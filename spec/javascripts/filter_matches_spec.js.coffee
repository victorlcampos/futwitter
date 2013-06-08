describe 'ChampionshipFilter', ->
  beforeEach ->
    loadFixtures("filter_matches_and_teams.html")
    window.select_championship = $("#championship")
    window.filter = new ChampionshipFilter(select_championship)

  describe '.filter_championships()', ->
    describe '1 championship is selected', ->
      beforeEach ->
        select_championship.val(1);
        filter.filter_championships();

      it 'should show current championships', ->
        expect($(".championship_1")).toBeVisible()

      it 'should filter others championships', ->
        expect($(".championship_2")).toBeHidden()
        expect($(".championship_3")).toBeHidden()

    describe '2 championship is selected', ->
      beforeEach ->
        select_championship.val(2);
        filter.filter_championships();

      it 'should show current championships', ->
        expect($(".championship_2")).toBeVisible()

      it 'should filter others championships', ->
        expect($(".championship_1")).toBeHidden()
        expect($(".championship_3")).toBeHidden()


    describe '3 championship is selected', ->
      beforeEach ->
        select_championship.val(3);
        filter.filter_championships()

      it 'should show current championships', ->
        expect($(".championship_3")).toBeVisible()

      it 'should filter others championships', ->
        expect($(".championship_1")).toBeHidden()
        expect($(".championship_2")).toBeHidden()

  describe 'contructor', ->
    it 'should initialize with current championship', ->
      expect(filter.get_selected_championship()).toBe("1")
    it 'should show current championships', ->
      expect($(".championship_1")).toBeVisible()

    it 'should filter others championships', ->
      expect($(".championship_2")).toBeHidden()
      expect($(".championship_3")).toBeHidden()

  describe 'on selected second championship', ->
    it 'should change the atual championship', ->
      select_championship.val(2)
      expect(filter.get_selected_championship()).toBe("2")

    it 'should call filter_championships', ->
      spyOn(filter, 'filter_championships')
      select_championship.trigger('change')
      expect(filter.filter_championships).toHaveBeenCalled()