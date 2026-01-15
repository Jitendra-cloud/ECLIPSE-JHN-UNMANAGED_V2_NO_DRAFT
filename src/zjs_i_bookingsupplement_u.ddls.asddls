@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement view - CDS data model'

define view entity ZJS_I_BOOKINGSUPPLEMENT_U
  as select from zjs_book_suppl as BookingSupplement

  association        to parent ZJS_I_BOOKING_U as _Booking        on  $projection.TravelID  = _Booking.TravelID
                                                                  and $projection.BookingID = _Booking.BookingID
  association [1..1] to ZJS_I_TRAVEL_U         as _Travel         on  $projection.TravelID = _Travel.TravelID

  association [1..1] to ZJS_I_SUPPLEMENT       as _Product        on  $projection.SupplementID = _Product.SupplementID
  association [1..*] to ZJS_I_SUPPLEMENTTEXT   as _SupplementText on  $projection.SupplementID = _SupplementText.SupplementID

{
  key BookingSupplement.travel_id             as TravelID,

  key BookingSupplement.booking_id            as BookingID,

  key BookingSupplement.booking_supplement_id as BookingSupplementID,

      BookingSupplement.supplement_id         as SupplementID,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingSupplement.price                 as Price,

      BookingSupplement.currency_code         as CurrencyCode,

      // _Booking.LastChangedAt as LastChangedAt,

      /* Associations */
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}
