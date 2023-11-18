namespace EventPlanr.Application.Extensions;

public static class DateTimeExtensions
{
    public static IEnumerable<DateTime> EachHourUntil(this DateTime from, DateTime to)
    {
        for (var day = from.Date; day.Date <= to.Date; day = day.AddHours(1))
            yield return day;
    }

    public static IEnumerable<DateTime> EachDayUntil(this DateTime from, DateTime to)
    {
        for (var day = from.Date; day.Date <= to.Date; day = day.AddDays(1))
            yield return day;
    }

    public static IEnumerable<DateTime> EachMonthUntil(this DateTime from, DateTime to)
    {
        for (var day = from.Date; day.Date <= to.Date; day = day.AddMonths(1))
            yield return day;
    }
}
