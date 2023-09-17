using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetUserEventTicketsQueryValidation : AbstractValidator<GetUserEventTicketsQuery>
{
    public GetUserEventTicketsQueryValidation()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
