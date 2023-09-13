using FluentValidation;

namespace EventPlanr.Application.Dto.Common;

public class LocationDtoValidator : AbstractValidator<LocationDto>
{
    public LocationDtoValidator()
    {
        RuleFor(x => x.Latitude)
            .NotNull();
        RuleFor(x => x.Longitude)
            .NotNull();
        RuleFor(x => x.Radius)
            .NotNull();
    }
}
