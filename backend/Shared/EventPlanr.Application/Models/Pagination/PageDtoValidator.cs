using FluentValidation;

namespace EventPlanr.Application.Models.Pagination;

public class PageDtoValidator : AbstractValidator<PageDto>
{
    public PageDtoValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThanOrEqualTo(1)
            .NotNull();
        RuleFor(x => x.PageSize)
            .GreaterThanOrEqualTo(1)
            .LessThanOrEqualTo(50)
            .NotNull();
    }
}
