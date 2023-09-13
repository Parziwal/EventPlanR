using FluentValidation;

namespace EventPlanr.Application.Dto.Common;

public class PageDataDtoValidator : AbstractValidator<PageDataDto>
{
    public PageDataDtoValidator()
    {
        RuleFor(x => x.PageNumber)
            .NotNull();
        RuleFor(x => x.PageSize)
            .NotNull();
        RuleFor(x => x.OrderDirection)
            .IsInEnum();
    }
}
