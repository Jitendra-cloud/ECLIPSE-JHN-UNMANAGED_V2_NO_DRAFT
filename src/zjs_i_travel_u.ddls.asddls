@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel view - CDS data model'

define root view entity ZJS_I_TRAVEL_U
  as select from zjs_travel as Travel -- the travel table is the data source for this view

  composition [0..*] of ZJS_I_BOOKING_U        as _Booking

  association [0..1] to ZJS_I_AGENCY           as _Agency        on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to ZJS_I_CUSTOMER         as _Customer      on $projection.CustomerID = _Customer.CustomerID
  association [0..1] to I_Currency             as _Currency      on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to ZJS_I_TRAVEL_STATUS_VH as _TravelStatus  on $projection.Status = _TravelStatus.TravelStatus

  association [1..1] to I_CalendarDate         as _CalendarBegin on $projection.BeginDate = _CalendarBegin.CalendarDate
  association [1..1] to I_CalendarDate         as _CalendarEnd   on $projection.EndDate = _CalendarEnd.CalendarDate

{
  key Travel.travel_id                                as TravelID,

      Travel.agency_id                                as AgencyID,

      Travel.customer_id                              as CustomerID,

      Travel.begin_date                               as BeginDate,

      Travel.end_date                                 as EndDate,

      concat( concat( substring(begin_date, 7, 2), '-' ),
              concat( concat( case _CalendarBegin._CalendarMonth._Text [1:Language = 'E' ].CalendarMonthName when 'Mar.' then 'Mar'
                              else substring(_CalendarBegin._CalendarMonth._Text [1:Language = 'E' ].CalendarMonthName, 1, 3 ) end , '-' ),
                      substring(begin_date, 3, 2) ) ) as FormatedBeginDate,

      concat( concat( substring(end_date, 7, 2), '-' ),
              concat( concat( case _CalendarEnd._CalendarMonth._Text [1:Language = 'E' ].CalendarMonthName when 'Mar.' then 'Mar'
                              else substring(_CalendarEnd._CalendarMonth._Text [1:Language = 'E' ].CalendarMonthName, 1, 3) end, '-' ),
                      substring(end_date, 3, 2) ) )   as FormatedEndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.booking_fee                              as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.total_price                              as TotalPrice,

      Travel.currency_code                            as CurrencyCode,

      Travel.description                              as Memo,

      Travel.status                                   as Status,

      Travel.lastchangedat                            as LastChangedAt,

      /* Associations */
      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _TravelStatus,
      _CalendarBegin,
      _CalendarEnd
}
