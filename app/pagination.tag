<test></test>
<script type="riot/tag">

  <paging-control>
    <style>
      .transparent{
        opacity:0;
      }
      .active{
        color:white;
      }
    </style>
    <ul class="pagination">
      <li class="waves-effect {transparent:current<4 || num_pages<6}" onclick={toPage} id="1">First</li>
      <li each={val, i in page_numbers} class="waves-effect {'active teal':val==current}" id={val} onclick={parent.toPage}>{val}</li>
      <li class="waves-effect {transparent:current+3>num_pages || num_pages<6}" onclick={toPage} id="-1">Last</li>
    </ul>
    this.num_pages = opts.num_pages;
    this.page_numbers = []
    this.current = 1;
    var self=this;
    this.on('mount',function(){
      var fiveless = self.num_pages<6?self.num_pages:5;
      for(var i = 1; i<=fiveless;i++){
        self.page_numbers.push(i)
      }
      console.log(self.page_numbers)
      self.update()
    })
    toPage(e){
      var pl = this.num_pages;
      var cur = this.current = parseInt(e.target.id=="-1"?pl:e.target.id);
      //If page length is more than 5 and has at leaset 2 more unshown pages,
      //show page number up to current page +2, otherwise show up to page length.
      var morepage = pl<5? pl:(cur<3? 5:(cur+1<pl?cur+2:pl) )
      self.page_numbers=[]
      for(var i = morepage-4>0?morepage-4:1; i<=morepage;i++){
        self.page_numbers.push(i)
      }
      self.parent.toPage(cur);
      this.update();
    }
  </paging-control>
</script>
<script type="riot/tag">

  <paging-panel>
    <style scoped>
    :scope{
      padding: 1rem;
      width:100%;
      display:inline-block;
    }
    .item{
      border:1px solid black;
    }
    .content{
      display:inline-block;
    }
    </style>
    <div class="content">
      <div class="item" each={val, i in page_items}>
        <yield/>
      </div>
    </div>
    <paging-control num_pages={num_pages}></paging-control>
    this.items = opts.items;
    this.page_items = [];
    this.per_page = opts.per_page;
    this.max_h = opts.max_h;
    this.min_h = opts.min_h;
    this.num_pages= Math.ceil(opts.items.length/opts.per_page);
    var self=this;
    this.on('mount',function(){
      self.num_pages = Math.ceil(self.items.length/self.per_page);
      self.page_items = self.items.slice(0,self.per_page)
      console.log(self.page_items)
      self.update();
    })
    toPage(number){
      self.page_items = self.items.slice((number-1)*self.per_page,number*self.per_page)
      self.update();
    }
  </paging-panel>

  <test>
    <style scoped>
       :scope{
        width:500px;
        position:absolute;
      }
    </style>

    <paging-panel items={items} per_page=3 per_row=2><a>{val.title}</a></paging-panel>
    this.items = [
      { title: "post 1"},
      { title: "post 2"},
      { title: "post 3"},
      { title: "post 4"},
      { title: "post 5"},
      { title: "post 6"},
      { title: "post 7"},
      { title: "post 8"},
      { title: "post 9"},
      { title: "post 10"},
      { title: "post 11"},
      { title: "post 12"},
      { title: "post 13"},
      { title: "post 14"},
      { title: "post 15"},
      { title: "post 16"},
      { title: "post 17"},
          { title: "post 18"},
          { title: "post 19"},
          { title: "post 20"}
    ]
  </test>
</script>
    
