using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetEventTicketsQueryValidator : AbstractValidator<GetEventTicketsQuery>
{
    public GetEventTicketsQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
