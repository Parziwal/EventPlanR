using FluentValidation;

namespace EventPlanr.Application.Models.Common;

public class AddressDtoValidator : AbstractValidator<AddressDto>
{
    public AddressDtoValidator()
    {
        RuleFor(x => x.Country)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.City)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.ZipCode)
            .MaximumLength(10)
            .NotEmpty();
        RuleFor(x => x.AddressLine)
            .MaximumLength(256)
            .NotEmpty();
    }
}
