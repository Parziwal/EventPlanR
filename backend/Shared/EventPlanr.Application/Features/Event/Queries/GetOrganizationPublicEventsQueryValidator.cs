using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationPublicEventsQueryValidator : AbstractValidator<GetOrganizationPublicEventsQuery>
{
    public GetOrganizationPublicEventsQueryValidator()
    {
        Include(new PageDtoValidator());
        RuleFor(x => x.OrganizationId)
            .NotEmpty();
    }
}
