Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64216E890
	for <netfs@lists.linux.dev>; Fri, 10 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340240; cv=none; b=ZyL00dIh2cvgg6BlqVuMlUHz1lUJzRgKmaQM7Bm4rggqS1a2JRbHVq/KZejHoMT15jV9vkddx64D966IQDo28tPFOX8+LzGkRBgn52/e0/ZJQzVqLyJOYzNS78T/WMC+GAVZjvvo8BXs7nc4f/12vfg1h5QIHqY+K9esx56nOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340240; c=relaxed/simple;
	bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHz3rdNs/bEitY+UAq9TGRra17R3oe5F7hP+E+5PoSdYDq3cV9TP9liGi2gTP8w/5LTtbOoDFLjji23gD5gfNPPjDqSgQsW96tTaUzoZp3BV0yXXJ7s8QHW1gyZKhU+8wLIRw66eHvbvk5iF5tgPW3J6weGO8JXKZ1XrsoDqi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=i8+46Mty; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i8+46Mty"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4702457ccbso486699566b.3
        for <netfs@lists.linux.dev>; Fri, 10 May 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715340237; x=1715945037; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=i8+46MtyQBgZUZzZKi8C3dUWlkDl1y4LzPjW0hbEF84DMk7OI8V9eE4VQGPjG6uUJZ
         JpGyFagvishyjZTUA8k21duCCFnlyhbnFoB4Q8hVF05UcZl6+gGQocTZuqRm988X5ZnX
         37TQY8HOrfKoQOKK8E+pvXpe/lFEsjaOYaFME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340237; x=1715945037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=CzwmuXs9Kux/4gBLp2CvqUkgoFF5fxH2XBJZo4+HMN9WapLvj7KdK7d4wDYpaUnjr1
         tVLs9/rjFGzVZ7ZKzR8Mca1TCqZvBCpQWtKYR81C0pthDv1I+KsGzkifzbV+YbjrW9Nm
         V46AyTQYl/RmIEEEsq/ao6HW+4Vx9GD3f0nYs5sAxl9cnkCz5nc69Ox4vBis1juynPdF
         eolnmVFdQjsemtCZ/YNmFRlrrBHrBbyvt6ZMANpGIhuqXnuUyg9TKQi6G+1g3bRUtEtc
         dDlyT33TXipQU5NRfelNRTK9YFHnkqIa+xdxwXkADgTc/+IuWM0sVYn7mnPmRAJY46HG
         xhQw==
X-Forwarded-Encrypted: i=1; AJvYcCVSRqHBzdd2h9wcNGb0MUI+rc2iINQFqC6DQdI+vCiH2qCyZXJ/9MiVX9E9FeeUQVOQ008HywIayYbxnBaIaXYysCRwNiI=
X-Gm-Message-State: AOJu0YxoposGbvzY8A4xK5hxZOpEAH6vDC1/+8rcRCalRL2QcaWOAn4K
	eUiTgzZjd1MYVVXpd/tLDnUMI26Vvo6KWV0UNTgAURjAuR+r6k6229gwNRsrzE6gdI7C1kZf2I+
	YeZtFi96Gknm/ThsAmqlp3p1w5En2eNt1afR5CQ==
X-Google-Smtp-Source: AGHT+IFz5qP18mAylhBbmtThupMzDKv7Hxf/YKoxmcI8024bWwzwHlVosWJHVpjswkQo1H6JZ+uOIVvInsfVrUzL8aQ=
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr199596766b.62.1715340236873; Fri, 10 May 2024
 04:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240502212631.110175-1-thorsten.blum@toblux.com> <20240502212631.110175-3-thorsten.blum@toblux.com>
In-Reply-To: <20240502212631.110175-3-thorsten.blum@toblux.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:23:45 +0200
Message-ID: <CAJfpegsVWa-fu=DePSC0J1WkfQxhaqs0RTxopMBHduwMANieyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] overlayfs: Remove duplicate included header
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 23:27, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Remove duplicate included header file linux/posix_acl.h
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied, thanks.

Miklos
