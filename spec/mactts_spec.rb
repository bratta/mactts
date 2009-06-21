require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'mactts'

describe Mac::TTS, "When using the class method" do
  before(:each) do
    @sample_text = "We ain't got no are spec!"
  end
  
  it "should say default text" do
    Mac::TTS.say(@sample_text).should == true
  end
  
  it "should say default text as alex" do
    Mac::TTS.say(@sample_text, :alex).should == true
  end
  
  it "should have an array of valid voices" do
    Mac::TTS.valid_voices.length.should > 0
  end
  
  it "should raise an error when an invalid voice is specified" do
    lambda { Mac::TTS.say(@sample_text, :beef)}.should raise_error(Mac::TTS::InvalidVoiceException)
  end
end

describe Mac::TTS, "When using an instantiated object" do
  before(:each) do
    @mactts = Mac::TTS.new
    @sample_text = "We ain't got no are spec!"  
  end
  
  it "should say default text" do
    @mactts.speak(@sample_text).should == true
  end
  
  it "should say default text as alex" do
    @mactts.voice = :alex
    @mactts.speak(@sample_text).should == true
  end
  
  it "should raise an error when an invalid voice is specified" do
    @mactts.voice = :beef
    lambda{ @mactts.speak(@sample_text) }.should raise_error(Mac::TTS::InvalidVoiceException)
  end
  
  it "should raise an error when an invalid command is specified" do
    @mactts.voice = :fred
    @mactts.say_command = '/should/not/exist'
    lambda{ @mactts.speak(@sample_text) }.should raise_error(Mac::TTS::SayCommandNotFoundException)
  end
  
  it "should return false if a valid command that is not say is specified" do
    @mactts.say_command = '/usr/bin/env'
    @mactts.speak(@sample_text).should == false
  end
end