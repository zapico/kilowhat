var flicker_store = 0;
//Client app for Carbon.to

$(document).ready(function() {

  //Initialize event-bindings

var  conversions = {
  	"led" : {"id":1,"slug":"led","unit":"hours with a LED lamp on","base_value":1,"name":"LED lamp","description":"led","icon":"","category_id":2,"carbon":0.006},
  	"fridge" : {"id":2,"slug":"fridge","unit":"years with a fridge on","base_value":1,"name":"New fridge","description":"led","icon":"","category_id":2,"carbon":200},
  	"bike" : {"id":3,"slug":"bike","unit":"km driving a electric assisted bike","base_value":1,"name":"Electric bike","description":"led","icon":"/images/solarpanel.jpg","category_id":3,"carbon":0.02},
  	"car" : {"id":4,"slug":"car","unit":"km driving an electric car","base_value":1,"name":"Electric car","description":"led","icon":"","category_id":3,"carbon":0.212},
  	"kwh" : {"id":5,"slug":"kwh","unit":"kwh","base_value":1,"name":"kwh","description":"led","icon":null,"category_id":1,"carbon":1.0},
  	"solarpanel" : {"id":6,"slug":"solarpanel","unit":"needed square meters of solar panels in a year.","base_value":1,"name":"Solar panel","description":"led","icon":"/images/solarpanel.jpg","category_id":1,"carbon":142.0},
  	"lightbulb" : {"id":7,"slug":"lightbulb","unit":"hours with a light bulb on","base_value":1,"name":"Light bulb","description":null,"icon":null,"category_id":2,"carbon":0.04},
  	"tv" : {"id":9,"slug":"tv","unit":"hours watching TV","base_value":1,"name":"TV","description":null,"icon":null,"category_id":2,"carbon":0.067},
  	"wifi" : {"id":10,"slug":"wifi","unit":"days with wifi on","base_value":1,"name":"WiFi","description":"wifi","icon":null,"category_id":2,"carbon":0.1368},
  	"heating" : {"id":11,"slug":"heating","unit":"hours heating a house with electric radiators","base_value":1,"name":"Heating","description":"average","icon":null,"category_id":0,"carbon":2.4},
  	"heatpump" : {"id":12,"slug":"heatpump","unit":"hours heating a house with a geothermal heatpump","base_value":1,"name":"Heating with heat pump","description":null,"icon":null,"category_id":0,"carbon":0.8},
  	"coal" : {"id":13,"slug":"coal","unit":"kg of coal needed to produce that electricity","base_value":1,"name":"Coal","description":null,"icon":null,"category_id":1,"carbon":2.1198},
  	"treadmill" : {"id":14,"slug":"treadmill","unit":"hours running in a treadmill to produce that electricity","base_value":1,"name":"Treadmill","description":null,"icon":null,"category_id":1,"carbon":0.1},
  	"hamburger" : {"id":15,"slug":"hamburger","unit":"hamburgers (energy needed to produce)","base_value":1,"name":"Hamburger","description":"","icon":"/images/units/burger.jpg","category_id":5,"carbon":3.9},
  	"mobile" : {"id":16,"slug":"mobile","unit":"mobile phone charges","base_value":1,"name":"Mobile phone","description":"","icon":"/images/units/mobile.jpg","category_id":2,"carbon":0.00545},
  	"oldcar" : {"id":17,"slug":"oldcar","unit":"km driving a gasoline car (eq)","base_value":1,"name":"Car","description":null,"icon":"/images/units/car.jpg","category_id":3,"carbon":0.8},
  	"washing" : {"id":18,"slug":"washing","unit":"washing machine loads","base_value":1,"name":"Washing Machine","description":null,"icon":"/images/units/washing.jpg","category_id":2,"carbon":0.96}
  };

var  index = [
    "kwh" ,  "bike" , "car" ,  "lightbulb" , "tv" , "led", "fridge" , "heating" , "heatpump" , "coal", "treadmill" , "solarpanel", "hamburger", "mobile", "oldcar", "washing"
  ];



  converter = new Carbon.Converter(conversions, index);
  converter.paint_left(true);

  //Expand the conversion drawer
  $(".toggle-conversions").bind("click", function(){
    var conversions = $(this).siblings(".conversions");

    if(conversions.hasClass("opened")){
      conversions.animate({"height": "0px"}, 500, "easeinout");
      conversions.removeClass("opened");
      $(this).removeClass("opened");
    }else{
      conversions.animate({"height": "150px"}, 500, "easeinout");
      conversions.addClass("opened");
      $(this).addClass("opened");
    }
  });

  // Add and subtract
  $("ul.add-subtract li.add").bind("click", function(){
    var conv = $(this).parent().parent()
    if(conv.attr("id") == "left"){
      var amount = converter.left_amount();
      if (amount < 1){
		amount = 1;
	  }else{
	  	amount = amount + 1;
	  }
      conv.find(".number").html(amount);
      converter.paint_right(true);
    }else{
      var amount = converter.right_amount();
      if (amount < 1){
		amount = 1;
	  }else{
	  	amount = amount + 1;
	  }
      conv.find(".number").html(amount);
      converter.paint_left(true);
    }
  });

  // Function for resetting to one
  $("ul.add-subtract li.r").bind("click", function(){
    var conv = $(this).parent().parent()
    if(conv.attr("id") == "left"){
      var amount = converter.left_amount();
      amount = 1;
      conv.find(".number").html(amount);
      converter.paint_right(true);
    }else{
      var amount = converter.right_amount();
      amount = 1;
      conv.find(".number").html(amount);
      converter.paint_left(true);
    }
  });

  $("ul.add-subtract li.subtract").bind("click", function(){
    var conv = $(this).parent().parent()
    if(conv.attr("id") == "left"){
      var amount = converter.left_amount();
      if(amount != 0) amount = amount - 1;
      conv.find(".number").html(amount);
      converter.paint_right(true);
    }else{
      var amount = converter.right_amount();
      if(amount != 0) amount = amount - 1;
      conv.find(".number").html(amount);
      converter.paint_left(true);
    }
  });

  $(".conversions ul li").bind("click", function(){
    if ($('#'+$(this).attr("class")).length == 0){
      $(this).parent().parent().siblings(".inner-converter").attr("id", $(this).attr("id"));
      if ($(this).parent().parent().parent().attr('id') == "left"){
        converter.paint_right(false);
        converter.paint_left(true);
      }else{
        converter.paint_left(false);
        converter.paint_right(true);
      }

    }
  });

});



 /*
  * jQuery Easing v1.1.1 - http://gsgd.co.uk/sandbox/jquery.easing.php
  *
  * Uses the built in easing capabilities added in jQuery 1.1
  * to offer multiple easing options
  *
  * Copyright (c) 2007 George Smith
  * Licensed under the MIT License:
  *   http://www.opensource.org/licenses/mit-license.php
  */

/* Extending jQuery easing functions here with the one required for the player */

jQuery.easing = jQuery.extend({
	easeinout: function(x, t, b, c, d) {
		if (t < d/2) return 2*c*t*t/(d*d) + b;
		var ts = t - d/2;
		return -2*c*ts*ts/(d*d) + 2*c*ts/d + c/2 + b;
  }
},jQuery.easing);

var Carbon = Carbon || {};
$.extend(Carbon, {
  Class: function() {
    return function() {
      this.initialize.apply(this, arguments);
    };
  }
});

Carbon.Converter = Carbon.Class();
Carbon.Converter.prototype = {
  initialize: function(conversions, index) {
    this.conversions = conversions;
    this.index = index;
    this.current = 0;
    $("#converter_background").css("background-image", "url('images/units/"+this.left_data().slug+".jpg')");
    $("#converter_background2").css("background-image", "url('images/units/"+this.right_data().slug+".jpg')");
  },
  data: function(id){
    return this.conversions[id];
  },
  random: function(){
    this.current = rand(this.index.length)
	// Avoiding haveing 0 vs 0 or CO2 vs CO2
	while ((this.current.right_amount() < 1) || (this.current.right_amount == this.current.left_amount)) {
		this.current = rand(this.index.length)
		};
    return this.conversions[this.index[this.current]];
  },
  next: function(){
    this.current ++;
    if (this.current >= this.index.length) this.current = 0;
    return this.conversions[this.index[this.current]];
  },
  previous: function(){
    this.current --;
    if (this.current < 0) this.current = this.index.length-1;
    return this.conversions[this.index[this.current]];
  },

  calculate_amount: function(slug, co2){
    return co2/this.conversions[slug].carbon;
  },

  left:function(){
    return $('#left div.inner-converter');
  },

  left_data:function(){
    return this.data(this.left()[0].id);
  },

  left_amount:function(){
    amount = this.left().find('.number').html();
	if (amount == "&lt;1"){
		amount = "0";
	};
    return parseInt(amount);

  },

  left_co2:function(){
    return this.left_amount()*this.left_data().carbon;
  },


  right:function(){
    return $('#right div.inner-converter');
  },

  right_data:function(){
    return this.data(this.right()[0].id);
  },

  right_amount:function(){
    var amount = this.right().find('.number').html();
	if (amount == "&lt;1"){
		amount = "0";
	};
    // amount = amount.replace('&lt;','');
    return parseInt(amount);
  },

  right_co2:function(){
    return this.right_amount()*this.right_data().carbon;
  },

  paint_left: function(recalculate){
    var container = this.left();
    var number = container.find('.number');
    var unit = container.find('.unit');
	var bg = container.find("converter_background");
    var html_amount = '';

    if(recalculate){
      var amount = Math.round(this.calculate_amount(this.left_data().slug,this.right_co2()));
      var do_spin = ((amount != this.left_amount()) && this.left_amount != 0 );
      if(amount == 0 && this.right_amount() != 0){
        html_amount = "&lt;1";
      }else{
        html_amount = amount.toString();
      }
      if (do_spin){
        this.spin_number(number, html_amount, amount.toString().length);
      }else{
        number.html(html_amount);
      }
      number.css('font-size',this.font_size(amount.toString().length));
      number.css('padding-top',this.font_padding(amount.toString().length));

    }
	$("#converter_background").css("background-image", "url('images/units/"+this.left_data().slug+".jpg')");
    unit.html(this.conversions[container.attr("id")].unit);
	//console.log(this.left_data().slug + " in " + this.right_data().slug);
	//actlog.info(this.left_data().slug + " in " + this.right_data().slug);
  },

  paint_right: function(recalculate){
    var container = this.right();
    var number = container.find('.number');
    var unit = container.find('.unit');
    var html_amount = '';


    if(recalculate){
      var amount = Math.round(this.calculate_amount(this.right_data().slug,this.left_co2()));
      var do_spin = ((amount != this.right_amount()) && this.right_amount != 0 );
      if(amount == 0 && this.left_amount() != 0){
        html_amount = "&lt;1";
      }else{
        html_amount = amount.toString();
      }
      if (do_spin){
		this.spin_number(number, html_amount, amount.toString().length);
      }else{
        number.html(html_amount);
      }
      number.css('font-size',this.font_size(amount.toString().length));
      number.css('padding-top',this.font_padding(amount.toString().length));
    }

    unit.html(this.conversions[container.attr("id")].unit);
	$("#converter_background2").css("background-image", "url('images/units/"+this.right_data().slug+".jpg')");
	//actlog.info(this.left_data().slug + " in " + this.right_data().slug);
  },

  font_size:function(digits){
    switch(digits){
      case 1:
      case 2:
      case 3:
        return "120px"
        break;
      case 4:
        return "120px"
        break;
      case 5:
        return "120px"
        break;
      case 6:
        return "120px"
        break;
      case 7:
        return "120px"
        break;
      case 8:
        return "120px"
        break;
      case 9:
      case 10:
      case 11:
        return "80px"
        break;
      case 12:
      case 13:
      case 14:
        return "60px"
        break;
      case 15:
      case 16:
      case 17:
      case 18:
      case 19:
      case 20:
        return "28px"
        break;
      default:
        return "10px"
        break;

    }
  },

  font_padding:function(digits){
    switch(digits){
      case 1:
      case 2:
      case 3:
        return "0px"
        break;
      case 4:
        return "0px"
        break;
      case 5:
        return "0px"
        break;
      case 6:
        return "0px"
        break;
      case 7:
        return "0px"
        break;
      case 8:
        return "90px"
        break;
      case 9:
      case 10:
      case 11:
        return "102px"
        break;
      case 12:
      case 13:
      case 14:
        return "102px"
        break;
      case 15:
      case 16:
      case 17:
      case 18:
      case 19:
      case 20:
        return "105px"
        break;
      default:
        return "110px"
        break;
      }
  },

  spin_number: function(number, html_amount, amount_length){
    var foo = 0;
    for(i = 0; i < 20; i++){
      foo += 20;
      setTimeout(function(){
        number.html(rand(Math.pow(10, amount_length)));
      }, foo);
    }
    setTimeout(function(){
      number.html(html_amount);
    }, 400);
  }
}


function rand(n){
  return ( Math.floor ( Math.random() * n )  );
}
