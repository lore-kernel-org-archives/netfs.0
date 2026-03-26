Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC303491E1
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516061; cv=none; b=q7hLQljDJ93aj0gdO7PsJHeRB14h43V+ITjafJjKXp8N+vD61ICJnYIKNpxPAHl/XolnxHlqGKSJ4QeH9gk2HTQucqXPdwXuzROxWD93rcTyy31NVHj70jdZvA2ZQS39W2UqY2twDi+KHwnvSd5M2vVbBzlu/rFVOryX7McGc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516061; c=relaxed/simple;
	bh=AhvTutpNDSH1ZnqHoPh2Qr+GKgd3XsnSEPuaEo1+oTI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ovb03NfQkGKu27Ow25wyZR+rLgl/FhVfDlxxtg5GG1CKDzJmCcmBBJMRMQIEB/dHiTGgNISggmuP4ohvDn7DqLZGx2+eYrQTrDHen5OePD9Y46tnDnkigStLclDuULjx8qFSza1EIr9R3yO8Iztw2eYLHqp2N2d9M6uaCY374Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ci0R/S5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPw5uZK1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ci0R/S5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPw5uZK1"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACEB6140023B;
	Thu, 26 Mar 2026 05:07:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 26 Mar 2026 05:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774516058; x=1774602458; bh=EJYv+PDF1XE+NSawL3FUaebZXRas4lB0PSe
	if3tk8+g=; b=Ci0R/S5q72qxxg8xuVzrvyDFG0kocISKxHtbYd/x+Oxd2keIZH2
	5d08Id+lpuOxwF9+itjGFLoqVkM9YfMdnruQr2pxnsLN/3ryvqKWqd2SvWOxEDoN
	1mPYm9/MCKsqUKuHHmnepSHIc7wf/pYV0rl9USk7cNA8Am2RY1ZLTFdM1HwbYwL8
	EfUZ5q3JGJ+pofBzy4yiJMFEvxEtsXyfp+/p2mvpTK6tGT1GOgWCVFK8erNt+Mdt
	o5Yc1CqCERgc8QuigOE+NrOfO0eUcLqHte/yi2g8c8EkkeOwdk2GaqbBiyJscq05
	qOYSD18TqTZ54pBKVghuOgkFTwbkiOlyy9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774516058; x=
	1774602458; bh=EJYv+PDF1XE+NSawL3FUaebZXRas4lB0PSeif3tk8+g=; b=j
	Pw5uZK1bs78sEYRY+T1bGx6U8XO5jO0ZB8QWO1bNRasoGJFWc/1Bi8IjKsdOTUq+
	XbF1j6Pt3OT9m5/e1LcwY7opaCxTV1o12Dt5+YTa9QF6AyCu+oa9JZ9nR1BPxWR7
	D/twH0TCPRKvVhFkSzfNUgXfDry5uxfsBuQwgML1CYwQrdDvv0z6KiqFUDamPAIy
	3DfA76zTjvtNhQQpoNRGC0qHH5Dl/2ul0JxnOVkIVmg/fYm4z6no1QAaLFC4nlKj
	7WspIEBlwZvuCllYlHwPW1oHGuWXLuUAHS0mfwBa7QBIM8/Fk7dul9luIdUQgGwK
	j+ywdRWjHT+nqKzhNKHfw==
X-ME-Sender: <xms:WvfEaQBQUZ-g2I1RXdPmXRn4aaAHK94Oc5Yr0Y1cVYJq0AozOHvXSg>
    <xme:WvfEaVHwMta2UWF3F0r2a-gXW3NY1JYhkTR4TykP_U2BxdOW-HsGCB6-CkjAUUvmE
    4LQXymHoUvZDnetwCn_BfBIa8DEB7vtSGafOVwfEDf_cHb3UQ>
X-ME-Received: <xmr:WvfEaXPtYkd41n5TSxszc7HTuLBzuXnWF5NwCYXto3mIFTMq_Epn48tO9RnX9QT8bmH5zk79-lRZwhaUJTtmDYvksShaSRGBnDoap-Kyywhu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepphgtsehmrghnghhuvggsihhtrdhorhhgpdhrtghpthhtohepnhgvthhfshes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrfhhssehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrdgtrdguihhonhhnvgesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:WvfEaW4hBfSP5G1qaAAQ7qm2Cn_FyIYcvlyiT4KHhQ68Z3gcvIdyKw>
    <xmx:WvfEaag_IDmsWAy44kVXtXOA4FGTjIEND3g9_jxyFhe4fpeN-cLgXQ>
    <xmx:WvfEabfAbbwtBr0bmDfytmUw8sYV-HOqKVgoJ7FL5KOI4s6_BTensw>
    <xmx:WvfEaSx0mvkxYP4GENh0IUJ2czgkFxFMuc59aU5vdSfuS63M8JVFdQ>
    <xmx:WvfEaT7wTggvIj7GTLTX1agYAq0AezpS2OXb6havrOsWz77zJL7Kgp41>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 05:07:36 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "David Howells" <dhowells@redhat.com>
Cc: "Marc Dionne" <marc.c.dionne@gmail.com>, dhowells@redhat.com,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Christian Brauner" <brauner@kernel.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
In-reply-to: <405501.1774511482@warthog.procyon.org.uk>
References:
 <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com>,
 <4001609.1774391729@warthog.procyon.org.uk>,
 <4002225.1774392603@warthog.procyon.org.uk>,
 <405501.1774511482@warthog.procyon.org.uk>
Date: Thu, 26 Mar 2026 20:07:32 +1100
Message-id: <177451605242.1851489.9347587959983302502@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 26 Mar 2026, David Howells wrote:
> Marc Dionne <marc.c.dionne@gmail.com> wrote:
>=20
> > I think it is the correct Fixes tag, but I'm not sure that this is
> > actually the right fix.  7bb1eb45e43c switched other callers of
> > cachefiles_bury_object to use start_removing_dentry, which gets an
> > additional ref, and removed the extra dget from
> > cachefiles_bury_object.  In the cachefiles_cull case however, the
> > dentry is from start_removing and has a single ref on entry to
> > cachefiles_bury_object, which is an issue as "rep" may be used there
> > after end_removing may have put the last ref.  So the correct is
> > probably for cachefiles_cull to add a dget() before the call to
> > cachefiles_bury_object.
>=20
> Ugh.  You're right.
>=20
> The problem is that we're calling start_removing() without knowing whether =
we
> can just unlink the object.  I wonder if I need to do the lookup in
> cachefiles_lookup_for_cull() and only then call start_removing_dentry() if
> it's not a directory (directories get moved to the graveyard for cachefilesd
> to tear down).
>=20
> I think the right solution is actually to move start_removing_dentry() down
> into cachefiles_bury_object() and make it contingent on the dentry being a
> non-dir.
>=20
> David
>=20
>=20

cachesfiles_bury_object() has a comment saying:

 * On entry there must be at least 2 refs on rep, one will be dropped on exit.

and this is consistent with the code in that function.

It is called from 3 places.
- cachefiles_invalidate_cookie(), cachesfiles_look_up_object(), and
  cachefiles_acquire_volume() all precede it with a
  start_removing_dentry() which results in 2 references to the dentry
  (the original and and extra which it takes) - so that fits with the
  comment.

- cachesfiles_cull() preceeds it with cachesfiles_lookup_for_cull()
  which uses start_removing() which returns with 1 reference to the
  dentry.  As the dentry didn't pre-exist, there is only one ref.
  So this is incorrect.

cachesfiles_cull() needs to take an extra reference to victim so that
when cachefiles_busy_object() calls end_removing, it still has a valid
reference.

So I think

--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -781,7 +781,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struc=
t dentry *dir,
 	if (ret < 0)
 		goto error_unlock;
=20
-	ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
+	ret =3D cachefiles_bury_object(cache, NULL, dir, dget(victim),
 				     FSCACHE_OBJECT_WAS_CULLED);
 	dput(victim);
 	if (ret < 0)

would be a correct fix.

If you agree I can post a properly formated patch which explanation.

Thanks,
NeilBrown
