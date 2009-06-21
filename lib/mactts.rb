require 'rubygems'
require 'tempfile'

# The program takes input and an optional voice and pipes it 
# through the Mac OS X "say" command for text-to-speech purposes.
# It uses a temp file to hold the output so the text can be any
# arbitrary length instead of relying on command-line limitations.
#
# Author:: Tim Gourley
# Copyright:: Copyright (C) 2009 Tim Gourley.
# License:: This application is protected under the GNU GPL v3

# This module contains the meat of the gem, the TTS class. The
# class can either be called statically with the say class 
# method, or you can instantiate the TTS object and mess with
# the defaults more easily.

module Mac
  class TTS
    attr_accessor :say_command, :voice, :tempfile
    
    class SayCommandNotFoundException < Exception; end
    class InvalidVoiceException < Exception; end
  
    # Initialize the class with a sane set of defaults
    # that can be overriden with the opts hash:
    #   opts = { :say_command  => '/path/to/say', 
    #            :tempfile     => 'tempfile_name',
    #            :voice        => :valid_voice
    #   }
    def initialize(opts = {})
      @say_command = opts[:say_command] || '/usr/bin/say'
      @tempfile    = opts[:tempfile]    || 'mactts'
      @voice       = opts[:voice]       || :fred
    end
  
    # Class method to make it easy to use the defaults
    # to say your text.
    # 
    # Usage:
    #   Mac::TTS.say('This is my text!', :alex)
    def self.say(text, voice = :fred)
      mactts = TTS.new(:voice => voice)
      mactts.say(text)
    end
  
    # Use TTS to speak your text, with the voice specified
    # in @voice.
    #
    # Usage:
    #    mactts = Mac::TTS.new
    #    mactts.say('This is my text!')
    def say(text)
      check_for_command
      validate_voice
      perform_say(text, @voice)
    end

    # An array of valid voice names recognized by the say command
    # Taken from the Speech preference pane.
    def self.valid_voices
      [ :alex, :fred, :bruce, :junior, :ralph, :agnes, :kathy, :princess, :vicki, :victoria,
        :albert, :bad, :bahh, :bells, :boing, :bubbles, :cellos, :deranged, :good, 
        :hysterical, :pipe, :trinoids, :whisper, :zarvox ]
    end
  
    private

    # Throw an exception if the command is not available
    def check_for_command
      if !File.exists?(@say_command) || !File.executable?(@say_command)
        # Throw an Exception
        raise SayCommandNotFoundException, "Command #{@say_command} not found or not executable"
      end
    end

    # Throw an exception if the voice is invalid
    def validate_voice
      if !is_valid_voice?
        # Throw an Exception
        raise InvalidVoiceException, "Voice '#{@voice}' is not a valid voice"
      end
    end

    # Check to see if the voice specified is in our valid list
    def is_valid_voice?
      TTS.valid_voices.include?(@voice)
    end

    # Write the temp file out and call the say command
    def perform_say(text, voice)
      temp_file = Tempfile.new(@tempfile)
      tf = File.new(temp_file.path, "w+")
      tf.puts(text)
      tf.close
      `cat #{temp_file.path} | #{@say_command} -v #{voice.to_s}`
      result = ($? == 0)
      temp_file.unlink      
      return result
    end
  end
end