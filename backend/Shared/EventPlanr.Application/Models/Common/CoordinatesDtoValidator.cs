using FluentValidation;

namespace EventPlanr.Application.Models.Common;

public class CoordinatesDtoValidator : AbstractValidator<CoordinatesDto>
{
    public CoordinatesDtoValidator()
    {
        RuleFor(x => x.Latitude)
            .GreaterThanOrEqualTo(-90)
            .LessThanOrEqualTo(90)
            .NotNull();
        RuleFor(x => x.Longitude)
            .GreaterThanOrEqualTo(-180)
            .LessThanOrEqualTo(180)
            .NotNull();
    }
}
