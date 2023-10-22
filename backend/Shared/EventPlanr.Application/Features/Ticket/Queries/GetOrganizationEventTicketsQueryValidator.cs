using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetOrganizationEventTicketsQueryValidator : AbstractValidator<GetOrganizationEventTicketsQuery>
{
    public GetOrganizationEventTicketsQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
