using FluentValidation;

namespace EventPlanr.Application.Models.Pagination;

public class PageWithOrderDtoValidator : AbstractValidator<PageWithOrderDto>
{
    public PageWithOrderDtoValidator()
    {
        Include(new PageDtoValidator());
        RuleFor(x => x.OrderDirection)
            .IsInEnum();
    }
}
