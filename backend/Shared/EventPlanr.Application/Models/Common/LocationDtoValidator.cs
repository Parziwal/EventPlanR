﻿using FluentValidation;

namespace EventPlanr.Application.Models.Common;

public class LocationDtoValidator : AbstractValidator<LocationDto>
{
    public LocationDtoValidator()
    {
        RuleFor(x => x.Latitude)
            .GreaterThanOrEqualTo(-90)
            .LessThanOrEqualTo(90)
            .NotNull();
        RuleFor(x => x.Longitude)
            .GreaterThanOrEqualTo(-180)
            .LessThanOrEqualTo(180)
            .NotNull();
        RuleFor(x => x.Radius)
            .GreaterThanOrEqualTo(1000)
            .LessThanOrEqualTo(100000)
            .NotNull();
    }
}
