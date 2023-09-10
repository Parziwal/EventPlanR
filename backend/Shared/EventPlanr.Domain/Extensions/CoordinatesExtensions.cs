using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Extensions;

public static class CoordinatesExtensions
{
    public static double GetDistance(this Coordinates from, Coordinates to)
    {
        var d1 = from.Latitude * (Math.PI / 180.0);
        var num1 = from.Longitude * (Math.PI / 180.0);
        var d2 = to.Latitude * (Math.PI / 180.0);
        var num2 = to.Longitude * (Math.PI / 180.0) - num1;
        var d3 = Math.Pow(Math.Sin((d2 - d1) / 2.0), 2.0) + Math.Cos(d1) * Math.Cos(d2) * Math.Pow(Math.Sin(num2 / 2.0), 2.0);

        return 6376500.0 * (2.0 * Math.Atan2(Math.Sqrt(d3), Math.Sqrt(1.0 - d3)));
    }
}
