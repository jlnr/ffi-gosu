module Gosu
  class Font
    extend FFI::Library
    ffi_lib Gosu::LIBRARY_PATH

    attach_function :_create_font, :Gosu_Font_create,   [:int, :string, :uint32], :pointer
    attach_function :_destroy_font, :Gosu_Font_destroy, [:pointer],               :void

    attach_function :_font_name,   :Gosu_Font_name,   [:pointer], :string
    attach_function :_font_height, :Gosu_Font_height, [:pointer], :int
    attach_function :_font_flags,  :Gosu_Font_flags,  [:pointer], :uint32

    attach_function :_font_text_width,   :Gosu_Font_text_width,   [:pointer, :string], :double
    attach_function :_font_markup_width, :Gosu_Font_markup_width, [:pointer, :string], :double

    attach_function :_font_draw_text,   :Gosu_Font_draw_text,   [:pointer, :string, :double, :double, :double,
                                                                 :double, :double, :uint32, :uint32],          :void
    attach_function :_font_draw_markup, :Gosu_Font_draw_markup, [:pointer, :string, :double, :double, :double,
                                                                 :double, :double, :uint32, :uint32],          :void

    attach_function :_font_draw_text_rel, :Gosu_Font_draw_text_rel,     [:pointer, :string, :double, :double, :double,
                                                                         :double, :double, :double, :double, :uint32, :uint32], :void
    attach_function :_font_draw_markup_rel, :Gosu_Font_draw_markup_rel, [:pointer, :string, :double, :double, :double,
                                                                         :double, :double, :double, :double, :uint32, :uint32], :void

    attach_function :_font_set_image, :Gosu_Font_set_image, [:pointer, :string, :uint32, :pointer], :void

    def initialize(height, name: Gosu.default_font_name, bold: false, italic: false, underline: false)
      __font = _create_font(height, name, Gosu.font_flags(bold, italic, underline))
      @memory_pointer = FFI::AutoPointer.new(__font, Gosu::Font.method(:release))
    end

    def __pointer
      @memory_pointer
    end

    def name
      _font_name(__pointer)
    end

    def height
      _font_height(__pointer)
    end

    def flags
      _font_flags(__pointer)
    end

    def text_width(text, scale_x = 1)
      _font_text_width(__pointer, text.to_s) * scale_x
    end

    def markup_width(text, scale_x = 1)
      _font_markup_width(__pointer, text.to_s) * scale_x
    end

    # Using Gosu::Font.draw is deprecated, use {Gosu::Font.draw_text} or {Gosu::Font.draw_markup}
    def draw(*args)
      draw_markup(*args)
    end

    def draw_rot(text, x, y, z, angle, scale_x = 1, scale_y = 1, c = Gosu::Color::WHITE, mode = :default)
      Gosu.rotate(angle, x, y) { draw_markup(text.to_s, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(c), Gosu.blendmode(mode)) }
    end

    def draw_text(text, x, y, z, scale_x = 1, scale_y = 1, c = Gosu::Color::WHITE, mode = :default)
      _font_draw_text(__pointer, text.to_s, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(c), Gosu.blendmode(mode))
    end

    def draw_markup(text, x, y, z, scale_x = 1, scale_y = 1, c = Gosu::Color::WHITE, mode = :default)
      _font_draw_markup(__pointer, text.to_s, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(c), Gosu.blendmode(mode))
    end

    def draw_rel(*args)
      draw_markup_rel(*args)
    end

    def draw_text_rel(text, x, y, z, rel_x, rel_y, scale_x = 1, scale_y = 1, c = Gosu::Color::WHITE, mode = :default)
      _font_draw_text_rel(__pointer, text.to_s, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(c), Gosu.blendmode(mode))
    end

    def draw_markup_rel(text, x, y, z, rel_x, rel_y, scale_x = 1, scale_y = 1, c = Gosu::Color::WHITE, mode = :default)
      _font_draw_markup_rel(__pointer, text.to_s, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(c), Gosu.blendmode(mode))
    end

    def []=(codepoint, image)
      _font_set_image(__pointer, codepoint, self.flags, image.__pointer)
    end

    def self.release(pointer)
      _destroy_font(pointer)
    end
  end
end