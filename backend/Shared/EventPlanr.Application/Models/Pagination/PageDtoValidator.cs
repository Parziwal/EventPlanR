using FluentValidation;

namespace EventPlanr.Application.Models.Pagination;

public class PageDtoValidator : AbstractValidator<PageDto>
{
    public PageDtoValidator()
    {
        RuleFor(x => x.PageNumber)
            .NotNull()
            .GreaterThanOrEqualTo(1);
        RuleFor(x => x.PageSize)
            .NotNull()
            .GreaterThanOrEqualTo(1)
            .GreaterThanOrEqualTo(50);
    }
}
