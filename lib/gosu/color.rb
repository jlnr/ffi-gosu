module Gosu
  class Color
    extend FFI::Library
    ffi_lib Gosu::LIBRARY_PATH

    attach_function :_create_color,      :Gosu_Color_create,                [:uint],                        :uint
    attach_function :_create_color_argb, :Gosu_Color_create_argb,           [:uchar, :uchar, :uchar, :uchar], :uint
    attach_function :_create_color_from_ahsv, :Gosu_Color_create_from_ahsv, [:uchar, :uchar, :uchar, :uchar], :uint
    attach_function :_create_color_from_hsv, :Gosu_Color_create_from_hsv,   [:uchar, :uchar, :uchar],         :uint


    attach_function :_color_alpha,       :Gosu_Color_alpha,      [:uint], :uchar
    attach_function :_color_red,         :Gosu_Color_red,        [:uint], :uchar
    attach_function :_color_green,       :Gosu_Color_green,      [:uint], :uchar
    attach_function :_color_blue,        :Gosu_Color_blue,       [:uint], :uchar

    attach_function :_color_set_alpha,   :Gosu_Color_set_alpha,  [:uint, :uchar], :uint
    attach_function :_color_set_red,     :Gosu_Color_set_red,    [:uint, :uchar], :uint
    attach_function :_color_set_green,   :Gosu_Color_set_green,  [:uint, :uchar], :uint
    attach_function :_color_set_blue,    :Gosu_Color_set_blue,   [:uint, :uchar], :uint


    attach_function :_color_value,      :Gosu_Color_value,      [:uint], :uchar
    attach_function :_color_saturation, :Gosu_Color_saturation, [:uint], :uchar
    attach_function :_color_hue,        :Gosu_Color_hue,        [:uint], :uchar

    attach_function :_color_set_value,      :Gosu_Color_set_value,      [:uint, :uchar], :uint
    attach_function :_color_set_saturation, :Gosu_Color_set_saturation, [:uint, :uchar], :uint
    attach_function :_color_set_hue,        :Gosu_Color_set_hue,        [:uint, :uchar], :uint


    attach_function :_color_bgr,  :Gosu_Color_bgr,  [:uint], :uint
    attach_function :_color_abgr, :Gosu_Color_abgr, [:uint], :uint
    attach_function :_color_argb, :Gosu_Color_argb, [:uint], :uint

    def self.argb(*args)
      Gosu::Color.new(*args)
    end

    def self.rgba(r, g, b, a)
      Gosu::Color.new(a, r, g, b)
    end

    def self.rgb(r, g, b)
      Gosu::Color.new(255, r, g, b)
    end

    def self.from_ahsv(aphla, h, s, v)
      Gosu::Color.new(_create_color_from_ahsv(aphla, h, s, v))
    end

    def self.from_hsv(h, s, v)
      Gosu::Color.new(_create_color_from_hsv(h, s, v))
    end

    def initialize(*args)
      case args.size
      when 1
        @__color = _create_color(args.first)
      when 4
        @__color = _create_color_argb(args[0], args[1], args[2], args[3])
      else
        raise "Error"
      end
    end

    def alpha
      _color_alpha(@__color)
    end

    def alpha=(value)
      @__color = _color_set_alpha(@__color, value)
    end

    def red
      _color_red(@__color)
    end

    def red=(value)
      @__color = _color_set_red(@__color, value)
    end

    def green
      _color_green(@__color)
    end

    def green=(value)
      @__color = _color_set_green(@__color, value)
    end

    def blue
      _color_blue(@__color)
    end

    def blue=(value)
      @__color = _color_set_blue(@__color, value)
    end

    def value
      _color_value(@__color)
    end

    def value=(value)
      _color_set_value(@__color, value)
    end

    def saturation
      _color_saturation(@__color)
    end

    def saturation=(value)
      _color_set_saturation(@__color, value)
    end

    def hue
      _color_hue(@__color)
    end

    def hue=(value)
      _color_set_hue(@__color, value)
    end

    def bgr
      _color_bgr(@__color)
    end

    def abgr
      _color_abgr(@__color)
    end

    def argb
      _color_argb(@__color)
    end

    def gl
      @__color
    end

    def ==(other)
      gl == other.gl
    end

    def <(other)
      gl < other.gl
    end

    def >(other)
      gl > other.gl
    end

    NONE    = Gosu::Color.argb(0x00_000000)
    BLACK   = Gosu::Color.argb(0xff_000000)
    GRAY    = Gosu::Color.argb(0xff_808080)
    WHITE   = Gosu::Color.argb(0xff_ffffff)
    AQUA    = Gosu::Color.argb(0xff_00ffff)
    RED     = Gosu::Color.argb(0xff_ff0000)
    GREEN   = Gosu::Color.argb(0xff_00ff00)
    BLUE    = Gosu::Color.argb(0xff_0000ff)
    YELLOW  = Gosu::Color.argb(0xff_ffff00)
    FUCHSIA = Gosu::Color.argb(0xff_ff00ff)
    CYAN    = Gosu::Color.argb(0xff_00ffff)
  end
end