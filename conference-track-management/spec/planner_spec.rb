# Talk List Spec
require 'talk_list'
require 'talk'
require 'planner'

describe 'planner' do
  it 'can add talks to a session when there is enough time' do
    list = TalkList.new

    talk1 = Talk.new 'talk one 10min'
    talk2 = Talk.new 'talk two 20min'
    list << talk1 << talk2

    planner = Planner.new

    result = planner.plan list, [30]

    expect(result[0].talks.length).to eq 2
    expect(result[0].talks[0]).to eq talk1
    expect(result[0].talks[1]).to eq talk2
  end

  it 'can go to a second session when the first is full' do
    list = TalkList.new

    talk1 = Talk.new 'talk one 10min'
    talk2 = Talk.new 'talk two 20min'
    talk3 = Talk.new 'talk three 20min'
    list << talk1 << talk2 << talk3

    planner = Planner.new

    result = planner.plan list, [30, 30]

    expect(result.length).to eq 2
    expect(result[0].talks.length).to eq 2
    expect(result[0].talks[0]).to eq talk1
    expect(result[0].talks[1]).to eq talk2
    expect(result[1].talks.length).to eq 1
    expect(result[1].talks[0]).to eq talk3
  end

  it 'it splits four talks across two sessions' do
    list = TalkList.new

    talk1 = Talk.new 'talk one 20min'
    talk2 = Talk.new 'talk two 20min'
    talk3 = Talk.new 'talk three 10min'
    talk4 = Talk.new 'talk four 10min'
    list << talk1 << talk2 << talk3 << talk4

    planner = Planner.new

    result = planner.plan list, [30, 30]

    expect(result.length).to eq 2
    expect(result[0].talks.length).to eq 2
    expect(result[0].talks[0]).to eq talk1
    expect(result[0].talks[1]).to eq talk3
    expect(result[1].talks.length).to eq 2
    expect(result[1].talks[0]).to eq talk2
    expect(result[1].talks[1]).to eq talk4
  end
end
