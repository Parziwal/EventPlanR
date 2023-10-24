using FluentValidation;

namespace EventPlanr.Application.Models.Common;

public class CoordinateDtoValidator : AbstractValidator<CoordinateDto>
{
    public CoordinateDtoValidator()
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
