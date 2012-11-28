//cx and cy are coordinates to the top-left corner of the frag graph
//type is used to describe color values, while labels are string representations
//hue 3/3 = RED => IP, hue 1/3 = GREEN => Free, hue 2/3 = BLUE => DHCP
function type_des(a) {
  switch(a) {
    case 1: return "Free"; break;
    case 2: return "DHCP"; break;
    case 3: return "Static IP"; break;
    default: return ""; break;
  }
};

Raphael.fn.fragChart = function (cx, cy, height, length, values, type, net_no, stroke) {
  var paper = this,
      chart = this.set();

  Array.prototype.max = function () {
    return Math.max.apply(Math, this);
  };

  var total = 0,
      x = cx,
      y = cy,
      ms = 500,
      p = this.set(),
      max = 3;//type.max();
      process = function(j) {
        var value = values[j],
            width = length * value/total,
            color = Raphael.hsb(type[j]/max, .75, 1),
            p = paper.rect(x,y,width,height,0).attr({fill: color, stroke: stroke, "stroke-width": 1}),
            txt = paper.text(x+width/2,height/6, type_des(type[j]) + " Block\n"+net_no[j]+" - "+net_no[j+1]).attr({fill: color, stroke: "none", opacity: 0, "font-size": 20});
            p.mouseover(function () {
                txt.stop().animate({opacity: 1}, ms, "elastic");
            }).mouseout(function () {
                txt.stop().animate({opacity: 0}, ms);
            });
            chart.push(p);
            chart.push(txt);
            x += width;
      };


  for (var i = 0, ii = values.length; i < ii; i++) {
    total += values[i];
  }

  for (i = 0; i < ii; i++) {
    process(i);
  }


  return chart;
};
