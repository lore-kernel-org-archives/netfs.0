Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F304D8DA
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906199; cv=none; b=ock2i70uzPj74q8CqorlhBPvRTH5tvSifhwUCoyR1An0QpT+k5DCBQHGkoVk6vnJMFPDuPgO+IqfsHxsBBnchWAAAbaGmgAnx8eoEjAU0ZpNqL8ayGQCKVEqu7PN3PWNqa73xpE0uy6N6rAcwr4aGhKFbZvuPRrgK6jJWCSjaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906199; c=relaxed/simple;
	bh=iUulgUB5zdTSBPIMLbSqfRvMV15wVFf/dFgCphdFGR4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=WTVYhEAMLow0QSRDjfXih7qqjWARjcxPAU/BavBGKW+M6te4VtaTH2qZEcAxCtUUGtwti1VwjOXFNKMpLJTrHwnVNW3eR8zWmr+07Q7O+FUv++yqo/BcJFaoL/oqP+z0xmi7RDkcS7wNgHwVql+2nXcDbM4u5CNeEV+WjmxMWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWNAWKSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWNAWKSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732906196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdYXzH/UDXmIMGYsmn37sxuBcBNh1lDdBuJCosAdeow=;
	b=TWNAWKScL9egXQ+dRGpHCIeBEeL2VUmGkzky0yW+mhy/UFJsbs07KeHw7SGpuKReW82Gke
	Hv62VE9ZVdVk2WGA/TsCvAaSDpLPhkZqofPDphC9zXVra3hcDeeJ/e8dUdS9widykKjZ13
	iJ85w4YCJBijyXnTMOMKSbf47rDmojg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-W9N96A9rPYOwsLvZexHjbQ-1; Fri,
 29 Nov 2024 13:49:53 -0500
X-MC-Unique: W9N96A9rPYOwsLvZexHjbQ-1
X-Mimecast-MFC-AGG-ID: W9N96A9rPYOwsLvZexHjbQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37C471955DC8;
	Fri, 29 Nov 2024 18:49:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04742300018D;
	Fri, 29 Nov 2024 18:49:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+8k-FxPFyomULC8MqVo-gvnaJNLrvfccVgb1uXZ24yFvw@mail.gmail.com>
References: <CAKPOu+8k-FxPFyomULC8MqVo-gvnaJNLrvfccVgb1uXZ24yFvw@mail.gmail.com> <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com> <4022108.1732899245@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: New cachefilesd implementation
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 18:49:49 +0000
Message-ID: <4039834.1732906189@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eK3d3Y1q070V4Vu6Uku5id3l0bD-Dxj9SeNED_DLags_1732906192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Max Kellermann <max.kellermann@ionos.com> wrote:

> On Fri, Nov 29, 2024 at 5:54=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> > Now, would you be able to clone this:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachef=
ilesd.git/
> >
> > Then rip out the existing code and put in your code?
>=20
> You mean create a merge commit from your repository? This would make
> it easier for people to "upgrade" by using a simple "git pull" on
> their existing clone. Is that what you want?

Yep.  Otherwise we have to go through the package replacement processes in
various distributions to replace cachefilesd with your one of a different
name.

> > There's some stuff in
> > there that is necessary to run on SELinux-based systems and it would ma=
ke it
> > a lot easier for me just to replace the current cachefilesd package by =
just
> > pulling yours directly.
>=20
> I wrote my implementation only for our own use (it solves an important
> problem we had), but if you want to retire yours and make mine the
> successor ("cachefilesd v2"?), I'd be willing to integrate all
> existing features. And give up the silly project name ;-) (naming is
> hard)

Yep.  If it does much the same thing, but more efficiently and faster, then
why not?

> > Also, you are using a simplified BSD licence - can you make it joint
> > BSD/GPL?
>=20
> Yes.

Thanks:-)

David

