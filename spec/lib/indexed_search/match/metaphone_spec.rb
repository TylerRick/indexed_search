require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe IndexedSearch::Match::Metaphone do
  set_perform_match_type :metaphone

  context 'standard' do
    before(:each) { @f1 = create(:indexed_foo, :name => 'thing') }
    it('find1') { find_results_for('thin').should be_empty }
    it('find2') { find_results_for('thing').models.should == [@f1] }
    it('find3') { find_results_for('things').should be_empty }
    it('find4') { find_results_for('th1ng').models.should == [@f1] }
    it('find5') { find_results_for('theng').models.should == [@f1] }
    it('find6') { find_results_for('think').models.should == [@f1] }
  end

  context 'single letter' do
    before(:each) { @f1 = create(:indexed_foo, :name => 't') }
    it('should be found') { find_results_for('t').models.should == [@f1] }
  end
  context 'two letters' do
    before(:each) { @f1 = create(:indexed_foo, :name => 'th') }
    it('should be found') { find_results_for('th').models.should == [@f1] }
  end
  context 'single number' do
    before(:each) { @f1 = create(:indexed_foo, :name => '1') }
    it('should not be found') { find_results_for('1').should be_empty }
  end
  context 'two numbers' do
    before(:each) { @f1 = create(:indexed_foo, :name => '12') }
    it('should not be found') { find_results_for('12').should be_empty }
  end
  context 'two letters and a number' do
    before(:each) { @f1 = create(:indexed_foo, :name => 'th1') }
    it('should not be found') { find_results_for('th1').models.should == [@f1] }
  end

end
