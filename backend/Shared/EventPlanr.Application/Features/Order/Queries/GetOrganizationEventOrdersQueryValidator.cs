using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Order.Queries;

public class GetOrganizationEventOrdersQueryValidator : AbstractValidator<GetOrganizationEventOrdersQuery>
{
    public GetOrganizationEventOrdersQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        Include(new PageDtoValidator());
    }
}
