extension PackageTarget.Target.TargetDependency {

    public enum TargetDependencyCondition: Equatable {
        case when(When)
    }
}
