﻿using FluentValidation.Results;

namespace EventPlanr.Application.Exceptions.Common;

public class ValidationException : Exception
{
    public ValidationException()
        : base(nameof(ValidationException))
    {
        Errors = new Dictionary<string, string[]>();
    }

    public ValidationException(IEnumerable<ValidationFailure> failures)
        : this()
    {
        Errors = failures
            .GroupBy(e => e.PropertyName, e => e.ErrorCode)
            .ToDictionary(failureGroup => failureGroup.Key, failureGroup => failureGroup.ToArray());
    }

    public IDictionary<string, string[]> Errors { get; }
}
