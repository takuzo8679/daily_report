require_relative '../lib/ticket'
class Gate

  # FARE = {
  # umeda:  {juso:  160, mikuni: 190},
  # juso:   {umeda: 160, mikuni: 160},
  # mikuni: {umeda: 190, juso:   160}
  # }
  FARES = [160, 190]
  STATIONS = [:umeda, :juso, :mikuni]

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.stamp(@name)
  end

  def calc_fare(ticket)
    # dept_id = STATIONS.index(dept)
    # dest_id = STATIONS.index(dest)
    FARES[STATIONS.index(@name) - STATIONS.index(ticket.stamped_at) -1]

  end

  def exit(ticket)
    # ticket.fare >= FARE[ticket.stampted_at][@name]
    ticket.fare >= calc_fare(ticket)
  end

end