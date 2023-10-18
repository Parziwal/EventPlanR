using EventPlanr.Application.Features.Organization.Commands;
using EventPlanr.Application.Features.Organization.Queries;
using EventPlanr.Application.Models.Organization;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.OrganizationManager.Api;

[ApiController]
[Route("organizationmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet]
    public Task<OrganizationDto> GetUserCurrentOrganization()
        => _sender.Send(new GetUserCurrentOrganizationQuery());

    [HttpGet("organizations")]
    public Task<List<OrganizationDto>> GetUserOrganizations()
        => _sender.Send(new GetUserOrganizationsQuery());

    [HttpGet("details")]
    public Task<UserOrganizationDetailsDto> GetUserCurrentOrganizationDetails()
        => _sender.Send(new GetUserCurrentOrganizationDetailsQuery());


    [HttpPost("set/{organizationId}")]
    public Task SetUserOrganization(Guid organizationId)
        => _sender.Send(new SetUserOrganizationCommand()
        {
            OrganizationId = organizationId,
        });

    [HttpPost]
    public Task<Guid> CreateOrganization([FromBody] CreateOrganizationCommand command)
        => _sender.Send(command);

    [HttpPut]
    public Task EditCurrentOrganization([FromBody] EditUserOrganizationCommand command)
        => _sender.Send(command);

    [HttpDelete]
    public Task DeleteCurrentOrganization()
        => _sender.Send(new DeleteUserOrganizationCommand());

    [HttpPost("member")]
    public Task AddMemberToCurrentOrganization([FromBody] AddMemberToUserOrganizationCommand command)
        => _sender.Send(command);

    [HttpPut("member")]
    public Task EditCurrentOrganizationMember([FromBody] EditOrganizationMemberCommand command)
        => _sender.Send(command);

    [HttpDelete("member")]
    public Task RemoveMemberFromCurrentOrganization([FromBody] RemoveMemberFromUserOrganizationCommand command)
        => _sender.Send(command);
}
