extends CanvasModulate

export(Color) var daytime_color = Color.white
export(Color) var nighttime_color = Color.darkblue
export(int) var half_cycle_length = 150

func _ready():
  self.color = daytime_color
  var tween = get_tree().create_tween()
  tween.bind_node(self)
  tween.set_loops(-1)
  tween.tween_property(self, "color", Color(1, 0.6, 0.2), half_cycle_length / 2).from(daytime_color) # lerp from white to yellow over a period of half the cycle length
  tween.tween_property(self, "color", nighttime_color, half_cycle_length / 2).from(Color(1, 0.6, 0.2)) # lerp from yellow to blue over a period of half the cycle length
  tween.tween_property(self, "color", Color(0.9, 0.7, 0.2), half_cycle_length / 2).from(nighttime_color) # lerp from blue to orange over a period of half the cycle length
  tween.tween_property(self, "color", daytime_color, half_cycle_length / 2).from(Color(0.9, 0.7, 0.2)) # lerp from orange to white over a period of half the cycle length
