@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking view'


define view entity ZJS_I_BOOKING_U
  as select from zjs_booking as Booking

  association        to parent ZJS_I_TRAVEL_U     as _Travel     on  $projection.TravelID = _Travel.TravelID
  composition [0..*] of ZJS_I_BOOKINGSUPPLEMENT_U as _BookSupplement

  association [1..1] to ZJS_I_CUSTOMER            as _Customer   on  $projection.CustomerID = _Customer.CustomerID
  association [1..1] to ZJS_I_CARRIER             as _Carrier    on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to ZJS_I_CONNECTION          as _Connection on  $projection.AirlineID    = _Connection.AirlineID
                                                                 and $projection.ConnectionID = _Connection.ConnectionID
{

  key Booking.travel_id     as TravelID,

  key Booking.booking_id    as BookingID,

      Booking.booking_date  as BookingDate,

      Booking.customer_id   as CustomerID,

      Booking.carrier_id    as AirlineID,

      Booking.connection_id as ConnectionID,

      Booking.flight_date   as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Booking.flight_price  as FlightPrice,

      Booking.currency_code as CurrencyCode,

      // _Travel.LastChangedAt as LastChangedAt, -- Take over ETag from parent

      /* Associations */
      _Travel,
      _BookSupplement,
      _Customer,
      _Carrier,
      _Connection

}
