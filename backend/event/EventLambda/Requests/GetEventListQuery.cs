using EventLambda.Models;
using MediatR;

namespace EventLambda.Requests;

public class GetEventListQuery : IRequest<List<Event>>
{
}
