# encoding: UTF-8
# Copyright 2016 Max Trense
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

describe Cite::Template do
  
  context 'empty template' do
    subject { Cite::Template(File.expand_path('../template/empty.cite', __FILE__)) }
    
    it { expect(subject.render).to be }
    it { expect(subject.render).to be_empty }
  end
  
  context 'simple template' do
    subject { Cite::Template(File.expand_path('../template/simple.cite', __FILE__)) }
    
    it { expect(subject.render(name: 'Fred')).to be }
    it { expect(subject.render(name: 'Fred')).to eq("Hello Fred!") }
  end
  
  context 'simple template with instance' do
    subject { Cite::Template(File.expand_path('../template/instance.cite', __FILE__)) }
    let(:obj) { Class.new { def up(str) str.upcase end ; def initialize() @name = 'Barney' end }.new }
    
    it { expect(subject.render(obj, name: 'Barney')).to be }
    it { expect(subject.render(obj, name: 'Barney')).to eq("Hello BARNEY!") }
  end
  
end
